module RepoHelper
  
  def create_new_repo(loc, user)
    repo = SITE_PROPS['repospath'] + '/' + user + '/' + loc
    mkdir = 'mkdir -p ' + repo
    init = 'cd ' + repo + ' && git init'
    logger.debug 'making repo - ' + mkdir
    system(mkdir)
    logger.debug 'initializing bare repo - git init'
    system(init)
  end
  
  def get_tree_by_name(repo, name)
    r = repo.tree
    return r./(name)
  end
  
  def get_lang(filename)
    filetype = filename.split( '.' )
    if filetype.last == "rb"
      lang = "ruby"
    end 
    if filetype.last == "java"
      lang = "java"
    end
    if lang.nil?
      lang = "all"
    end
    return "[code lang='#{lang}']"
  end

  
  def watch_a_repo(repo_id)
     watch = user?.watchers.new(:repodb_id => repo_id)
     if watch.save
       return true
     else
       return false
     end
  end
  
  def unwatch_a_repo(id)
     watch = Repodb.find(id).watchers.find_by_user_id(session[:user_id]).destroy
     if watch.save
       return true
     else
       return false
     end
  end
  
end

class Array
  
  def names
    self.collect {|x| x = x.name }
  end
  
end
  