import { LightningElement, api, track, wire } from 'lwc';
import FlowModal from 'c/flowModal';
import { getRecord } from 'lightning/uiRecordApi';
import getCommitmentInformation from '@salesforce/apex/GiftCommitmentSetupController.getCommitmentInformation';
import NAME_FIELD from '@salesforce/schema/GiftCommitment.Name';

export default class GiftCommitmentSetup extends LightningElement {
    @api recordId;
    @track loading = true;
    @track refresh = false;
    @track commitmentInformation = null;
    @track setupNotComplete = false;
    @track hasSchedules = false;
    @track hasDesignations = false;

    @wire(getRecord, {recordId: '$recordId', fields: [NAME_FIELD]})
    wiredRecord( {error,data}) {
        if ( data ) {
            this.fetchCommitmentInformation();
        }
        if ( error ) {
            console.log ( error );
        }
    }

    fetchCommitmentInformation() {
        getCommitmentInformation({commitmentId:this.recordId})
        .then ( result => {
            this.hasDesignations = result.hasDesignationRecords;
            this.hasSchedules = result.hasCommitmentSchedule;
            this.setupNotComplete = (this.hasDesignations === false || this.hasSchedules === false );
            this.loading = false;
            this.refresh = false;
        }).catch(error => {
            // TODO
        });
    }

    refreshDetails ( event ) {
        this.refresh = true;
        this.fetchCommitmentInformation();
    }
    async openFlow ( event ) {
        let flow = ( event.target.dataset.flow === 'manageschedules') ? 'manageschedules' : 'designation';
        const result = await FlowModal.open({
            size: 'large',
            commitmentId: this.recordId,
            quickActionAPIName: flow
        });
        
        this.dispatchEvent(new CloseActionScreenEvent());
        
    }   
}