import '../styles/_deployable.scss'
import React from 'react'
import ReactDOM from 'react-dom'
import { Router, Route, browserHistory } from 'react-router'
import { Provider } from 'mobx-react'

import Todos from '../components/Todos'
import todoStore from '../stores/TodoStore'

const app = document.getElementById('root');

ReactDOM.render(
	<Provider store={todoStore}>
		<Router history={browserHistory}>
			<Route path="/" component={Todos}/>
		</Router>
	 </Provider>,
	app
)
