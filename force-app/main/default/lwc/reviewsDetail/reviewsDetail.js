import { api, LightningElement, wire } from 'lwc';
import getReviewList from '@salesforce/apex/ReviewController.getReviewList';

export default class ReviewsDetail extends LightningElement {

    @api
    tvSerieId;
    reviews;

    @wire(getReviewList,{tvSerieId:'$tvSerieId'}) getReview({data,error}){
        if(data) {
            this.reviews = data;
            console.log(data);
        } else if(error) {
            console.log(error);
        }
    }


}