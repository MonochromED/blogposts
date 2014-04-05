#Deletes old news and replaces with new news listed below
#Run in command line 

#News.delete_all#Uncomment to delete all existing news entries.
#------------------------------------------------------------
#News.delete_all
#Review.delete_all

#Uncomment below to add in a new News entry to the database.  Uncomment and fill value for data members.
#----------------------------------------------------------------------------------
#tempVar = News.new
#tempVar.id = 0#Uncomment and specify ID value to edit existing entry.
#tempVar.title = "Spicy New Italian!"#Review News Title Here
#tempVar.article = "A new Italian cafe has opened up on the waterfront.  Spicy style."#article here.
#tempVar.date = Time.now.getutc

#tempVar.save