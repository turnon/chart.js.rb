# MyChart.js

generate chart.js html with ruby

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'my_chart'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install my_chart

## Usage

suppose you want to have some statistic on mail files:

```ruby
MyChart.js do

  material do
    # load mail objects here
  end

  select :fail do |m|
    m.fail?
  end

  line :day, :fail?, w: 1280, h: 500, asc: :key

  bar :day, w: 1280, h: 500

  bar :day, w: 1280, h: 500, from: :fail

  output './mail_statistic.htm'
end
```

execute the script:

```sh
    $ mychart.js mail_st.rb
```

## Supported charts

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

