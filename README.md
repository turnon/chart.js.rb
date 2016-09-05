# mychart.js.rb

generate chart.js html with ruby

## usage

suppose you want to have some statistic on mail files:

```ruby
MyChart.js do

  material do
    # load mail objects here
  end

  line w: 1280, h: 500 do
    group :GROUP_BY_day, by: :fail_or_not do |m|
      m.fail? ? 'FAIL' : 'SUCC'
    end
  end

  bar w: 1280, h: 500  do
    group by: :day do |m|
      m.day
    end
  end

  bar w: 1280, h: 500  do
    group :fail, by: :day do |m|
      m.day
    end
  end

  select :fail do |m|
    m.fail?
  end

  output './mail_statistic.htm'

end
```

execute the script:

```sh
    $ mychartjs mail_st.rb
```

## supported charts

bar, doughnut, line, pie, polar_area, radar are built-in with basic style

if you would like to add custom style, this is for your reference:

```ruby
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
```

## todo

simplify it like this:

```ruby
MyChart.js do

  material do
    # load mail objects here
  end

  select :fail do |m|
    m.fail?
  end
  
  line :day, :fail?, w: 1280, h: 500

  bar :day, w: 1280, h: 500

  bar :day, w: 1280, h: 500, from: :fail

  output './mail_statistic.htm'
end
```
