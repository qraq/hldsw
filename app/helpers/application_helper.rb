module ApplicationHelper
# Return a title on a per-page basis.
def title
base_title = "Ruby on Rails Tutorial Sample App"
if @title.nil?
base_title
else
"#{base_title} | #{@title}"
end
end

def logo
  image_tag("logo.png", :alt => "Sample App", :class => "round")
end

###################

@@log = '/home/qraq/Desktop/hlds/cstrike/logi/log'
def hostname
         
   File.readlines(@@log).each do |line| 
   @line = line.split(':') if line =~ /hostname/    
   end
   if @line.nil?
     return nil
   else
    @line.delete("hostname")
    @line.join(' ')
   end
end

def version
         
   File.readlines(@@log).each do |line| 
   @line = line.split(':') if line =~ /version/    
   end
 @line.delete("version ")
 @line.join(' ')
end

def map
         
   File.readlines(@@log).each do |line| 
   @line = line.split(':') if line =~ /map/    
   end
 @line.delete("map     ")
 @line.join(' ')
end

def tcp
        
   File.readlines(@@log).each do |line| 
   @line = line.split(':') if line =~ /tcp\/ip/    
   end
 @line.delete("tcp/ip  ")
 @line.join(' ')
end

def players
        
   File.readlines(@@log).each do |line| 
   @line = line.split(':') if line =~ /players/    
   end
 @line.delete("players ")
 @line.join(' ')
end
end

