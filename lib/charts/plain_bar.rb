class PlainBar < MyChart::Proto

  same_color_on_x

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
