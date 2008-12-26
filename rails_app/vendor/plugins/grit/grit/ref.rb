module Grit

  class Ref

    class << self

      # Find all Refs
      #   +repo+ is the Repo
      #   +options+ is a Hash of options
      #
      # Returns Grit::Ref[] (baked)
      def find_all(repo, options = {})      
        refs = []

        Dir.chdir(repo.path) do
          if File.file?('packed-refs')
            File.readlines('packed-refs').each do |line|
              if m = /^(\w{40}) (.*?)$/.match(line)
                next if !Regexp.new('^' + prefix).match(m[2])
                name = m[2].sub("#{prefix}/", '')
                commit = Commit.create(repo, :id => m[1])
                refs << self.new(name, commit)
              end
            end
          end
          
          files = Dir.glob(prefix + '/**/*')
          files.each do |ref|
            next if !File.file?(ref)
            id = File.read(ref).chomp
            name = ref.sub("#{prefix}/", '')
            commit = Commit.create(repo, :id => id)
            refs << self.new(name, commit)
          end
        end
                
        refs
      end

      protected

        def prefix
          "refs/#{name.to_s.gsub(/^.*::/, '').downcase}s"
        end

    end

    attr_reader :name
    attr_reader :commit

    # Instantiate a new Head
    #   +name+ is the name of the head
    #   +commit+ is the Commit that the head points to
    #
    # Returns Grit::Head (baked)
    def initialize(name, commit)
      @name = name
      @commit = commit
    end

    # Pretty object inspection
    def inspect
      %Q{#<#{self.class.name} "#{@name}">}
    end
  end # Ref

  # A Head is a named reference to a Commit. Every Head instance contains a name
  # and a Commit object.
  #
  #   r = Grit::Repo.new("/path/to/repo")
  #   h = r.heads.first
  #   h.name       # => "master"
  #   h.commit     # => #<Grit::Commit "1c09f116cbc2cb4100fb6935bb162daa4723f455">
  #   h.commit.id  # => "1c09f116cbc2cb4100fb6935bb162daa4723f455"
  class Head < Ref

    # Get the HEAD revision of the repo.
    #   +repo+ is the Repo
    #   +options+ is a Hash of options
    #
    # Returns Grit::Head (baked)
    def self.current(repo, options = {})
      head = File.open(File.join(repo.path, 'HEAD')).read.chomp
      if /ref: refs\/heads\/(.*)/.match(head)
        self.new($1, repo.git.rev_parse(options, 'HEAD'))
      end
    end

  end # Head

  class Tag < Ref ; end

  class Remote < Ref; end
  
end # Grit
