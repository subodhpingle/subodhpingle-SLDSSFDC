import { LightningElement,api} from 'lwc';

export default class Test_Date extends LightningElement {
    @api tdate;
    tdate = new Date().toDateString() ;
}