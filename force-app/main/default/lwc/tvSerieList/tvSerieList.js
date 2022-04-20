import { LightningElement, wire } from 'lwc';
import getTvSerieList from '@salesforce/apex/TvSerieController.getTvSerieList';
export default class TvSerieList extends LightningElement {

    //loaded data
    @wire(getTvSerieList) tvSerieList;
    //id of selected record
     tvSerieId;

    handleChangeRadio(event){        
        this.tvSerieId = event.target.value;
        window.console.log('tvSerieId' + this.tvSerieId);
       const myCustomEventItem = new CustomEvent('displayTvSerieEvent',{
            detail: this.tvSerieId
       });
       this.dispatchEvent(myCustomEventItem);
        
    }
}