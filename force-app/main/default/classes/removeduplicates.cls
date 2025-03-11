public class removeduplicates {
    
    public static void removingduplicates(){
        list<integer> listvar=new list<integer>{200,302,302,400,500,500,600,600};
         set<integer> newset=new set<integer>(listvar);
        list<integer> newlist=new list<integer>(newset);
        system.debug('The final list after removing duplicates:'+newlist);
    }
 
}

//In order to remove duplicates from a list, we have to convert list to a set and then convert that set back to a list.