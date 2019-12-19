
import csv

Top_500=[]
#file_name = "data.csv"
file_name = "/Users/rebjl/Documents/Data Science Coursework/nyc-ds-111819-lectures/Mod_1/rolling-stones/data.csv"
with open(file_name) as csvfile:
   reader = csv.DictReader(csvfile)
   for row in reader:
       Top_500.append(row)
print(Top_500)

print("hi")
k=0
master={}
album_name={}
album_year={}
album_artist={}
album_rank={}
albums_by_artist={}
for a in Top_500:
   #created master with master[k]=a
   master[k]=a
   #creates a dictionary with artist:[list,of,albums],artist2[list,of,albums]
   if a["artist"] in albums_by_artist:
       albums_by_artist[a["artist"]].append(k)
   else:
       albums_by_artist[a["artist"]]=[k]
   #lists all the album names
   album_name[a["album"]]=k
   #prints album year:[index,for.master,for,albums,that,are,in,that,year]
   #would usually have to create the list(k) before appending it, but the first case of this list will have to skip
   #over the if and go straight to the else because no albums years have been created yet
   if a["year"] in album_year:
       #print(“Existing list: {}“.format(album_year[a[‘year’]]))
       #print(“Adding {} to existing list”.format(a[‘year’]))
       album_year[a["year"]].append(k)
   else:
       #print(“Creating initial list for {}“.format(a[‘year’]))
       #had to create a list in this case so that we can append it
       #album_year[a[‘year’]]=[]
       #album_year[a[‘year’]]=album_year[a[‘year’]].append(k)
       album_year[a["year"]]=[k]
       #print(“Album year initial: {}“.format(album_year[a[‘year’]]))
   album_artist[a["artist"]]=k
   album_rank[a["number"]]=k
   k+=1
#print(master)
#print(master[0])
#print(“\n”)
#print(album_name)
#print(album_year)
def find_by_name(n):
   if n in album_name:
       ind = album_name[n]
       return(master[ind])
def find_by_rank(n):
   n=str(n)
   if n in album_rank:
       ind = album_rank[n]
       return(master[ind])
   else:
       return None
def find_by_year(n):
   results=[]
   n=str(n)
   if n in album_year:
       ind = album_year[n]
       for i in ind:
           results.append(master[i])
       #print(ind)
       return(results)
   else:
       return None
def find_by_ranks(start,end):
   results=[]
   x=range(start,end)
   for r in x:
       results.append(find_by_rank(r))
   return(results)
def find_by_years(start,end):
   results=[]
   x=range(start,end)
   for r in x:
       results.append(find_by_year(r))
   return(results)
def all_titles():
   return album_name.keys()
def all_artists():
   return album_artist.keys()


#def artist_with_most_albums():
#print(albums_by_artist)
#all_artists()
#all_titles()
#find_by_years(1966,1980)
#find_by_year(1967)
#print(master[ind])
#def test():
   #a = find_by_name(“Sgt. Pepper’s Lonely Hearts Club Band”)
   #print (a)
  # b = find_by_rank(1)
   #print (b)
   #c = find_by_year(1967)
   #print(c)
#test()