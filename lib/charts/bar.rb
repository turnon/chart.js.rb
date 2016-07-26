class Bar < MyChartType::Proto

  def concrete_type
    :bar
  end

  def concrete_options
    {
       scales: {
         yAxes: [{
             ticks: {
                 beginAtZero:true
             }
         }]
       }
     }
  end

end
