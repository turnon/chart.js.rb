class PlainBar < MyChart::Proto

  same_color_on_x

  def concrete_type
    :bar
  end

  def concrete_options
    opt = {
       scales: {
         yAxes: [{
             ticks: {
                 beginAtZero:true
             }
         }]
       }
     }
    opt.merge!({legend: {display: false}}) unless has_z?
    opt
  end

end
