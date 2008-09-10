grit
    by Tom Preston-Werner, Chris Wanstrath
    http://github.com/mojombo/grit

== DESCRIPTION:

Grit is a Ruby library for extracting information from a git repository in and
object oriented manner.

== REQUIREMENTS:

* git (http://git.or.cz) tested with 1.5.3.4

== INSTALL:

  $ gem sources -a http://gems.github.com/ (you only need to do this once)
  $ gem install mojombo-grit

== SOURCE:

Grit's git repo is available on GitHub, which can be browsed at:

  http://github.com/mojombo/grit

and cloned from:

  git://github.com/mojombo/grit.git

== USAGE:

Grit gives you object model access to your git repository. Once you have
created a repository object, you can traverse it to find parent commit(s),
trees, blobs, etc.

= Initialize a Repo object

The first step is to create a Grit::Repo object to represent your repo. I
include the Grit module so reduce typing.

  require 'mojombo-grit'
  include Grit
  repo = Repo.new("/Users/tom/dev/grit")
  
In the above example, the directory /Users/tom/dev/grit is my working
repo and contains the .git directory. You can also initialize Grit with a 
bare repo.

  repo = Repo.new("/var/git/grit.git")
  
= Getting a list of commits

From the Repo object, you can get a list of commits as an array of Commit
objects.

  repo.commits
  # => [#<Grit::Commit "e80bbd2ce67651aa18e57fb0b43618ad4baf7750">,
        #<Grit::Commit "91169e1f5fa4de2eaea3f176461f5dc784796769">,
        #<Grit::Commit "038af8c329ef7c1bae4568b98bd5c58510465493">,
        #<Grit::Commit "40d3057d09a7a4d61059bca9dca5ae698de58cbe">,
        #<Grit::Commit "4ea50f4754937bf19461af58ce3b3d24c77311d9">]
        
Called without arguments, Repo#commits returns a list of up to ten commits
reachable by the master branch (starting at the latest commit). You can ask
for commits beginning at a different branch, commit, tag, etc.

  repo.commits('mybranch')
  repo.commits('40d3057d09a7a4d61059bca9dca5ae698de58cbe')
  repo.commits('v0.1')
  
You can specify the maximum number of commits to return.

  repo.commits('master', 100)
  
If you need paging, you can specify a number of commits to skip.

  repo.commits('master', 10, 20)
  
The above will return commits 21-30 from the commit list.
        
= The Commit object

Commit objects contain information about that commit.

  head = repo.commits.first
  
  head.id
  # => "e80bbd2ce67651aa18e57fb0b43618ad4baf7750"
  
  head.parents
  # => [#<Grit::Commit "91169e1f5fa4de2eaea3f176461f5dc784796769">]
  
  head.tree
  # => #<Grit::Tree "3536eb9abac69c3e4db583ad38f3d30f8db4771f">
  
  head.author
  # => #<Grit::Actor "Tom Preston-Werner <tom@mojombo.com>">
  
  head.authored_date
  # => Wed Oct 24 22:02:31 -0700 2007
  
  head.committer
  # => #<Grit::Actor "Tom Preston-Werner <tom@mojombo.com>">
  
  head.committed_date
  # => Wed Oct 24 22:02:31 -0700 2007
  
  head.message
  # => "add Actor inspect"
  
You can traverse a commit's ancestry by chaining calls to #parents.

  repo.commits.first.parents[0].parents[0].parents[0]
  
The above corresponds to master^^^ or master~3 in git parlance.

= The Tree object

A tree records pointers to the contents of a directory. Let's say you want
the root tree of the latest commit on the master branch.

  tree = repo.commits.first.tree
  # => #<Grit::Tree "3536eb9abac69c3e4db583ad38f3d30f8db4771f">
  
  tree.id
  # => "3536eb9abac69c3e4db583ad38f3d30f8db4771f"
  
Once you have a tree, you can get the contents.

  contents = tree.contents
  # => [#<Grit::Blob "4ebc8aea50e0a67e000ba29a30809d0a7b9b2666">,
        #<Grit::Blob "81d2c27608b352814cbe979a6acd678d30219678">,
        #<Grit::Tree "c3d07b0083f01a6e1ac969a0f32b8d06f20c62e5">,
        #<Grit::Tree "4d00fe177a8407dbbc64a24dbfc564762c0922d8">]

This tree contains two Blob objects and two Tree objects. The trees are
subdirectories and the blobs are files. Trees below the root have additional
attributes.

  contents.last.name
  # => "lib"
  
  contents.last.mode
  # => "040000"
  
There is a convenience method that allows you to get a named sub-object
from a tree.

  tree/"lib"
  # => #<Grit::Tree "e74893a3d8a25cbb1367cf241cc741bfd503c4b2">
  
You can also get a tree directly from the repo if you know its name.

  repo.tree
  # => #<Grit::Tree "master">
  
  repo.tree("91169e1f5fa4de2eaea3f176461f5dc784796769")
  # => #<Grit::Tree "91169e1f5fa4de2eaea3f176461f5dc784796769">
  
= The Blob object

A blob represents a file. Trees often contain blobs.

  blob = tree.contents.first
  # => #<Grit::Blob "4ebc8aea50e0a67e000ba29a30809d0a7b9b2666">
  
A blob has certain attributes.

  blob.id
  # => "4ebc8aea50e0a67e000ba29a30809d0a7b9b2666"
  
  blob.name
  # => "README.txt"
  
  blob.mode
  # => "100644"
  
  blob.size
  # => 7726
  
You can get the data of a blob as a string.

  blob.data
  # => "Grit is a library to ..."
  
You can also get a blob directly from the repo if you know its name.

  repo.blob("4ebc8aea50e0a67e000ba29a30809d0a7b9b2666")
  # => #<Grit::Blob "4ebc8aea50e0a67e000ba29a30809d0a7b9b2666">

== LICENSE:

(The MIT License)

Copyright (c) 2007 Tom Preston-Werner

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
