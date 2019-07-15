public class OppsController {
    
    public List<BarChartData> getBarData() {
        List<BarChartData> barData = new List<BarChartData>();
        AggregateResult[] groupedResults  = [SELECT StageName ,Sum(ExpectedRevenue)  
                                             FROM Opportunity
                                             WHERE OwnerId =:UserInfo.getUserId()
                                             Group by StageName];
        for (AggregateResult ar : groupedResults)  {            
            if(ar.get('StageName')!=null)
            {
                barData.add(new BarChartData(
                    String.ValueOf(ar.get('StageName')),
                    Double.ValueOf(ar.get('expr0'))
                ));
            }    
        }      
        return barData;
    }
    public class BarChartData {
        public String stageName { get; set; }
        public Double expectedRevenue { get; set; }
        public BarChartData(String stageName, Double expectedRevenue) {
            this.stageName = stageName;
            this.expectedRevenue = expectedRevenue;
        }
    }
}