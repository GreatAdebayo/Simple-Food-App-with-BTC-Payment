import React, {useEffect, useState} from 'react'
import axios from 'axios';
import { Baseurl } from './baseurl';
import QRCode from 'react-qr-code';
import {useHistory} from 'react-router-dom';


const Payment = () => {
    const [details, setDetails] = useState('')
    let history = useHistory();
    useEffect(() => {
        let code = localStorage.Code;
        axios.post(`${Baseurl}payment.php`, JSON.stringify(code)
        ).then(res => {
            let info = res.data 
            localStorage.setItem('Details', JSON.stringify(info))
            let details = JSON.parse(localStorage.Details)
            setDetails(details);
            let address = details.address
            let socket = new WebSocket(`wss://www.blockonomics.co/payment/${address}`);
            socket.onmessage = function(event){
            let response = JSON.parse(event.data);
            //This condition ensures that we reload only when we get a 
             //new payment status and don't go into a loop
            if (parseInt(response.status) > parseInt(details.status)){
            setTimeout(function(){window.location.reload() }, 1000);
            // setTimeout(() => history.push('/order'), 1200);
            if(response.status == 2){
             history.push('/order')
            }
            
            } 
        }
        
           })
    }, [])
 

    return (
        <>
        <div className="container">
            <div className="row">
                <div className="col mt-5">
                <h4 className="text-center">BTC PAYMENT</h4>
                 {details ? <QRCode value={details.address} /> : null}
                  <p className="mt-5"><strong>Wallet Address: </strong>{details.address}</p>
                  <p><strong>Amount: </strong>{details.price}</p>
                  <p><strong>Status: </strong>{details.status == 0 ? <span>You payment has been received. Invoice will be marked paid on two blockchain confirmations.</span>:
                  details.status == 1 ? <span>You payment has been received. Invoice will be marked paid on two blockchain confirmations.</span>:
                  details.status == 2 ? <span>Paid</span>: 
                  details.status == -1 ? <span>Unpaid</span>:
                  details.status == -2 ? <span>Too little paid, please pay the rest.</span>:<span>Expired</span>}</p>
                  <p className="text-uppercase"><strong>Payment for: </strong>{details.product}</p>
                </div>

            </div>

        </div>

        
        </>
    )
}

export default Payment
