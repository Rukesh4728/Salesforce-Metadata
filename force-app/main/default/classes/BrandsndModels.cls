public class BrandsndModels {
    
    public static void Brandsandmodels(){
        Map<string, List<string>> newmap=new Map<string, List<string>>();
        newmap.put('Honda', new List<string>{'Jazz'});
        List<string> newlist=newmap.get('Honda');
        newlist.add('city');
        newlist.add('amaze');
        newlist.add('accord');
        newmap.put('Ford', new List<string>{'Ecosport'});
        List<string> anotherlist=newmap.get('Ford');
        anotherlist.add('Endeavour');
        anotherlist.add('Mustang');
        system.debug('The honda cars are:'+newmap.get('Honda'));
        system.debug('The ford cars are:'+newmap.get('Ford'));
        
    }

}