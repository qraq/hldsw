module UsersHelper
  def killscore(id)
    
    ip = players_online(id,9)[0..12]
    
    user = User.find_by_ip(ip)
    
       user.last_kill = 0 if user.last_kill.nil?
    
    current_score = Integer(players_online(id,5))
    dif = current_score - user.last_kill
    
    
    if dif < 0
      user.last_kill = 0
      dif = current_score - user.last_kill      
    end
    
    user.last_kill = current_score
    user.points = user.points+dif
    user.password = :password
    user.save
    
    #debug
    #"dif=" + dif.to_s + " db score=" + user.points.to_s + " last store=" +user.last_kill.to_s +  " current=" + current_score.to_s
  
end

  def deathscore(id)
    
    ip = players_online(id,9)[0..12]
    user = User.find_by_ip(ip)
    
    user.last_death = 0 if user.last_death.nil?
    
    current_score = Integer(players_online(id,8))
    dif = current_score - user.last_death
    
    
    if dif < 0
      user.last_death = 0
      dif = Integer(current_score) - user.last_death     
    end
    
    user.last_death = current_score
    user.death = user.death+dif
    user.password = :password
    user.save
    
    #debug
   # "dif=" + dif.to_s + " db score=" + user.death.to_s + " last store=" +user.last_death.to_s +  " current=" + current_score.to_s
  
end

  def kdratio
    @user = User.find(params[:id])
    death = 0 if @user.death.nil? 
    kill = 0 if @user.points.nil?    
    kill = @user.points
    death = @user.death
     if death == 0
        ratio = kill/1 
     else
        ratio = Float(kill)/Float(death)
     end
     return ratio.round(2)
   end
  
  
  
  
  def online(i)
    @user = User.find(params[:id])
    #@users = User.all
    
    #  i = 
      if !@user.find_ip(players_online(i,9)[0..12]).nil?
      #@user.find_ip(players_online(1,9)[0..12]) == @user.ip
       if @user.find_ip(players_online(i,9)[0..12]).ip == (@user.ip)
        return  @user.find_ip(players_online(i,9)[0..12]).name
       
      else 
        return nil
       end
          #     return  "Offline" 
       # else  
          #   return "Online"
        end
        #end
        return nil
      end

     













end

