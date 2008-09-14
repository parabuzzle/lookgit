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
