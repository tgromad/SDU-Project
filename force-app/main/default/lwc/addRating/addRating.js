import { LightningElement } from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';

import REVIEW_OBJECT from "@salesforce/schema/Review";

export default class AddRating extends LightningElement {

    reviewRecord = {};

    //flag
    isLoading = false;

    hanldeChange(event) {
        this.reviewRecord[event.target.name] = event.target.name;
    }
    createReview(){
        this.isLoading = true;
        const fields = this.reviewRecord;
        const recordInput = {apiName: REVIEW_OBJECT.objectApiName, fields};

createRecord(recordInput).then((Review)=>{
    this.reviewId = Review.id;
    this.dispatchEvent(
        new ShowToastEvent({
            title: "Success",
            message: "Review Created successfully!",
            variant: "sucess"
        })
    );
    this.reviewRecord = {};
    })
    .catch((error) => {
        this.dispatchEvent(
            new ShowToastEvent({
                title: "Error creating record",
                message: reduceErrors(error).join(", "),
                variant: "error"
            })
        );
    })
    .finally(() => {
        this.isLoading = false;
    });
}
}