public class Aggregate_operations {
    integer a=10;
    integer b=20;
    integer c=30;
    integer d;
    integer e;
    integer f;
    
    public void addition(){
        d=a+b+c;
        system.debug('addition values:'+d);
        subtraction();
        multiplication();
    }
    public void subtraction(){
        e=a-b-c;
        system.debug('subtraction values:'+e);
    }
    public void multiplication(){
        f=a*b*c;
        system.debug('Multiplication values:'+f);
    }

}