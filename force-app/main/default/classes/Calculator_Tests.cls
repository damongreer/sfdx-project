@isTest
private class Calculator_Tests {
    
    @isTest
    static void additionTest(){
        integer c = Calculator.addition(2, 4);
        system.assertEquals(6, c);
    }
    @isTest
    static void subtractionTest(){
        integer c = Calculator.subtraction(4, 2);
        system.assertEquals(2, c);
    }
    @isTest
    static void multiplyTest(){
        List<Boolean> exceptions = new List<Boolean>();
        integer c = Calculator.multiply(1, 7);
        system.assertEquals(7, c);
    }
    @isTest
    static void multiplyNegativeTest(){
        List<Boolean> exceptions = new List<Boolean>();
        integer c;
        try{
            c = Calculator.multiply(0, 7);
        }
        catch(Calculator.CalculatorException e){
            if(e.getMessage() == 'It doesn\'t make sense to multiply by zero'){
                exceptions.add(true);
            }
        }
    }
    @isTest
    static void divideTest(){
        List<Boolean> exceptions = new List<Boolean>();
        decimal d = Calculator.divide(25, 5);
        system.assertEquals(5, d);
        
    }    
    @isTest
    static void divideNegativeTest(){
        List<Boolean> exceptions = new List<Boolean>();
        decimal d;
        try{
            d = Calculator.divide(25, 0);
        }
        catch(Calculator.CalculatorException e){
            if(e.getMessage() == 'you still can\'t divide by zero'){
                exceptions.add(true);
            }
        }
    }
    @isTest
    static void divideNegativeValueTest(){
        List<Boolean> exceptions = new List<Boolean>();
        decimal returnValue;
        try{
            returnValue = Calculator.divide(-2, 2);
        }
        catch(Calculator.CalculatorException e){
            if(e.getMessage() == 'Division returned a negative value.' + returnValue){
                exceptions.add(true);
            }
        }
    }
}