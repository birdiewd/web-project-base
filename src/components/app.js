import "../styles/app.scss"
import React from "react"
import ReactDOM from "react-dom"
import { Router, Route, browserHistory } from 'react-router'
import { Provider } from 'mobx-react'

import Todos from './Todos'
import todoStore from './TodoStore'

const app = document.getElementById('root');

ReactDOM.render(
  <Provider store={todoStore}>
    <Router history={browserHistory}>
      <Route path="/" component={Todos}/>
    </Router>
   </Provider>,
  app
)
