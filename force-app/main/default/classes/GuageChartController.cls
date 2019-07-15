public class GuageChartController {
    
    public List<GuageChartData> getData() {
        List<GuageChartData> guageData = new List<GuageChartData>();
        AggregateResult[] groupedResults  = [SELECT Sum(ExpectedRevenue)  
                                             FROM Opportunity
                                             WHERE OwnerId =:UserInfo.getUserId()];
        for (AggregateResult ar : groupedResults)  {            
                guageData.add(new GuageChartData(
                    Double.ValueOf(ar.get('expr0'))
                ));
        }      
        return guageData;
    }
    public class GuageChartData {
        public Double expectedRevenue { get; set; }
        public GuageChartData(Double expectedRevenue) {
            this.expectedRevenue = expectedRevenue;
        }
    }
}