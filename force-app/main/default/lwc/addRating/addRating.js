import { LightningElement,api } from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';

export default class AddRating extends LightningElement {
    @api recordId
    rating;
    comment;
    // Change Handlers.
    ratingChangedHandler(event){
        this.rating = event.target.value;
    }
    commentChangeHandler(event){
        this.comment = event.target.value;
    }
    // Insert record.
    createReview(){
        // Creating mapping of fields of Account with values
        var fields = {'Rating__c' : this.rating, 'Comment__c' : this.comment,'TV_Serie__c' : this.recordId};
        // Record details to pass to create method with api name of Object.
        var objRecordInput = {'apiName' : 'Review__c', fields};
        // LDS method to create record.
        createRecord(objRecordInput).then(response => {
            alert('Review created!');
            this.updateRecordView();
        }).catch(error => {
            alert('Error: ' +JSON.stringify(error));
        });
    }
    updateRecordView() {
       setTimeout(() => {
            eval("$A.get('e.force:refreshView').fire();");
       }, 1000); 
    }
}