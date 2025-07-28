import { getRecord } from 'lightning/uiRecordApi';
import { LightningElement, api, track, wire } from 'lwc';
import {CloseActionScreenEvent} from 'lightning/actions';
import { CurrentPageReference } from "lightning/navigation";


import FlowModal from 'c/flowModal';
import NAME_FIELD from '@salesforce/schema/GiftCommitment.Name';

export default class TestButton extends LightningElement {
    @api recordId;
    @track loading = true;
    _recordId = null;
    @track openFlow = false;
    _quickActionPath = null;
    _quickActionAPIName = null;

    @wire(CurrentPageReference)
    getStateParameters(currentPageReference) {
        if (currentPageReference.type === "standard__quickAction") {
            this.openFlow = true;
            let quickActionPath = currentPageReference.attributes.apiName;
            this._quickActionAPIName = quickActionPath.split('.')[1];
        }
    }

    @wire(getRecord, {recordId: '$recordId', fields: [NAME_FIELD]})
    wiredRecord( {error,data}) {
        if ( data ) {
            this.loading = false;   
            if ( this.openFlow ) {
                this.openFlowModal();
            }
        }
        if ( error ) {
            console.log ( error );
        }
    }
    async openFlowModal(event) {
        const result = await FlowModal.open({
            size: 'large',
            commitmentId: this.recordId,
            quickActionAPIName: this._quickActionAPIName
        });
        
        this.dispatchEvent(new CloseActionScreenEvent());
        
    }
}