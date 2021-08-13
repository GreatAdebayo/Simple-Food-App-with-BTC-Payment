import React from 'react'
import { BrowserRouter as Router, Route, Switch } from 'react-router-dom';
import Products from './components/food'
import Payment from './components/payment'
import Order from './components/order';

const App = () => {
  return (
    <div>
      <Router>
       <Route exact path="/">
        <Products/>
       </Route>

        <Route path='/payment'>
        <Payment/>
        </Route>

        <Route path='/order'>
        <Order/>
        </Route>


      </Router>
      
    </div>
  )
}

export default App
