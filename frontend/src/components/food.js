import React, {useState} from 'react';
import axios from 'axios';
import { Baseurl } from './baseurl';
import {useHistory} from 'react-router-dom';


const Products = () => {
 let history = useHistory();
 const [food, setFood] = useState([{foodName: 'rice', price:50, img:'./rice.jpg', desc:'Sweet Rice buy it'}, 
 {foodName: 'burger', price:20, img:'./burger.jpg', desc:'Sweet Burger buy it'}])

 const handleSubmit = (price, foodName)=>{
 let food = {name:foodName, price:price}
 axios.post(`${Baseurl}invoice.php`, JSON.stringify(food)
      ).then(res => {
       if(res.data){
      let code = res.data
      localStorage.setItem('Code', code)
      history.push('/payment');
         }
      })

 }
    return (
        <>
          <div className="container">
            <div className="row mt-3">
              <h3><strong>FOOD MENU</strong></h3>
              {food.map((item, index) => {
                return (
                  <div className="col">
                    <div className="card" style={{ width: '18rem' }}>
                      <img src={item.img} class="card-img-top" alt="..." style={{ height: '250px' }} />
                      <div className="card-body">
                        <h5 class="card-title text-capitalize">{item.foodName}</h5>
                        <p class="card-text">{item.desc}</p>
                        <button href="" class="btn btn-primary" onClick={() => handleSubmit(item.price, item.foodName)}>Buy ${item.price}</button>
                      </div>
                    </div>
                  </div>
                )
              })}
            </div>
          </div>
           
        </>
    )
}

export default Products
