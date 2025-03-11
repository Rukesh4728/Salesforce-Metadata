public class secondlargest {
    
    public static void secondlargestelement(){
        list<integer> listvar= new list<integer>{20,10,15,40};
        list<integer>copiedlist=new list<integer>();
        for(integer element:listvar){
           copiedlist.add(element);
        }
        copiedlist.sort();
        integer secondlargest=copiedlist[copiedlist.size()-2];
       system.debug('The second largest element is:'+secondlargest);
    }

}

//To find second largest in a list, sort the elements and then choose the second largest based on their index numbers.