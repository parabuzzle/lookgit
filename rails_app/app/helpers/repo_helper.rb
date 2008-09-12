module RepoHelper
  
  def create_new_repo(repo)
    mkdir = 'mkdir -p ' + repo
    init = 'cd ' + repo + ' && git init'
    logger.debug 'making repo - ' + mkdir
    system(mkdir)
    logger.debug 'initializing bare repo - git init'
    system(init)
  end
  
  def watch_a_repo(repo_id)
     watch = Watcher.new(:repo_id => repo_id, :user_id => user?.id)
     if watch.save
       return true
     else
       return false
     end
  end
  
end
