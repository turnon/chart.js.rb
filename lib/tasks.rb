class Tasks

  ROOT = :__root__

  class Task

    attr_reader :id, :result
    attr_accessor :tasks

    def initialize params={}, &action
      @id = params[:id]
      @depends_on = params[:depends_on]
      @action = action
    end

    def exe
      return if @executed
      @executed = true
      prerequisite.exe
      if root?
        @result = @action.call
      else
        @result = @action.call prerequisite.result
      end
    end

    private
    
    def root?
      id == ROOT
    end

    def prerequisite
      tasks[@depends_on] or raise "task #{@depends_on} not found"
    end
  end

  def initialize
    @tasks = {}
  end

  def add id=nil, params={}, &action
    t = Task.new complete(id, params), &action
    raise "already has task #{t.id}" if @tasks[t.id]
    t.tasks = self
    @tasks[t.id] = t
  end

  def [] task_id
    @tasks[task_id] or raise "task #{task_id} not found"
  end

  def exe
    unless @tasks[ROOT]
      STDOUT.puts 'no default task !' 
      return
    end
    @tasks.values.each &:exe
  end

  def order
    @tasks.keys
  end

  private

  def complete id, params
    args = {}
    args[:id] = id ? id : ROOT
    args[:depends_on] = params[:depends_on] ? params[:depends_on] : ROOT
    args
  end

end