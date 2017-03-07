import React, { Component } from 'react'
import { inject, observer } from 'mobx-react'

import Todo from './Todo'

@inject('store')
@observer
export default class Todos extends Component {
	constructor() {
		super()

		this.handleCreateKeypress = this.handleCreateKeypress.bind(this)
		this.handleFilterChange = this.handleFilterChange.bind(this)
	}

	handleCreateKeypress(event) {
		if (event.which === 13) { // enter key
			this.props.store.createTodo(event.target.value) // add todo
			event.target.value = '' // clear todo text
		}
	}

	handleFilterChange(event) {
		this.props.store.filter = event.target.value
	}

	render() {
		const { completedTodos, filter, filteredTodos, todos } = this.props.store

		const todoList = filteredTodos.map(todo => (<Todo key={todo.id} todo={todo} />))

		const todoneList = completedTodos.map(todo => (<Todo key={todo.id} todo={todo} />))

		return (
			<div>
				<input placeholder="creat new" className="create" onKeyPress={this.handleCreateKeypress} />
				<input placeholder="filter" className="filter" value={filter} onChange={this.handleFilterChange} />

				<h1>Todo List</h1>

				<ul>{todoList}</ul>

				<h1>Todone List</h1>

				<ul>{todoneList}</ul>
			</div>
		);
	}
}
