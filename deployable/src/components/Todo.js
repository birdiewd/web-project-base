import React, {Component} from 'react'
import { inject, observer } from 'mobx-react'

@observer
export default class Todo extends Component {
	constructor() {
		super()

		this.handleCompleteToggle = this.handleCompleteToggle.bind(this)
	}

	handleCompleteToggle(e) {
		this.props.todo.complete = !this.props.todo.complete
	}

	render() {
		return (
			<li key={this.props.todo.id}>
				<input
					type="checkbox"
					value={this.props.todo.complete}
					checked={this.props.todo.complete}
					onChange={this.handleCompleteToggle}
				/>
				{this.props.todo.value}
			</li>
		);
	}
}
