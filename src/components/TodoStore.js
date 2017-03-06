import React, {Component} from 'react'
import { computed, observable } from 'mobx'

class Todo {
	@observable id
	@observable value
	@observable complete

	constructor(value) {
		this.value = value
		this.id = Date.now()
		this.complete = false
	}
}

export class TodoStore {
	@observable todos = []
	@observable filter = ''

	@computed get filteredTodos() {
		let matchedFilters = new RegExp(this.filter, 'i')

		return this.todos.filter(todo => {
			let passesFilter = !this.filter || matchedFilters.test(todo.value)
			let notDone = !todo.complete

			return passesFilter && notDone
		})
	}

	@computed get completedTodos() {
		let matchedFilters = new RegExp(this.filter, 'i')

		return this.todos.filter(todo => {
			let passesFilter = !this.filter || matchedFilters.test(todo.value)
			let isDone = todo.complete

			return passesFilter && isDone
		})
	}

	createTodo(todo) {
		this.todos.push(new Todo(todo))
	}
}

export default new TodoStore
