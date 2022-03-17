class TodosController < ApplicationController
    def index
        page = params['page'].nil? ? '1' : params['page']

        if page.to_i < 1
            redirect_to controller: 'todos', action: 'index'
            return
        end

        @todos = Todo.order(id: :desc).paginate(page: page, per_page: 3)
        @todo = Todo.new
    end

    def show
        redirect_to controller: 'todos', action: 'index'
    end

    def create
        @todo = Todo.new(todo_params)
        if @todo.save
            respond_to do |format|
                format.html { redirect_to @todo, notice: "Todo was successfully created." }
                format.js {}
            end
        else
            respond_to do |format|
                format.js { render error: @todo.errors.full_messages, status: :created }
            end
        end
    end

    def destroy
        @todo = Todo.find(params[:id]).destroy
        if @todo
            respond_to do |format|
                format.html { redirect_to @todo, notice: "Todo was successfully deleted." }
                format.js {}
            end
        else
            respond_to do |format|
                format.js { render error: @todo.errors.full_messages, status: :created }
            end
        end
    end

    def update
        @todo = Todo.find(params[:id])
        if @todo.todo_complete == 0
            @todo.update(todo_complete: 1)
        else
            @todo.update(todo_complete: 0)
        end
        respond_to do |format|
            format.html { redirect_to @todo, notice: "Todo was successfully deleted." }
            format.js {}
        end
    end

    private
    def todo_params
      params.require(:todo).permit(:todo_info, :todo_complete)
    end
end
