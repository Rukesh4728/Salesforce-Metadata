public class DistinctPairs {
    static integer a=80;
    public static void distinctvaluepairs(){
        list<integer> newlist=new list<integer>{10,35,45,50,60};
        
            for(integer x=0; x<newlist.size();x++){
                integer b=newlist[x];
                integer diff= a-b;
                if(newlist.contains(diff)){
                    list<integer> listone = new list<integer>();
                     listone.add(b);
                    listone.add(diff);
                    system.debug('The list is:'+listone);
                }
             
            }
    }

}