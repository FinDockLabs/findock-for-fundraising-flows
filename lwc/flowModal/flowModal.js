import { api, track } from 'lwc';
import LightningModal from 'lightning/modal';
import getFlowConfigurations from '@salesforce/apex/FlowLauncherController.getFlowConfigurations';
export default class FlowModal extends LightningModal {
    @api commitmentId;
    @api quickActionAPIName;
    _manageFlow = null;
    _updateFlow = null;
    _designationFlow = null;
    @track loading = true;
    handleConfirm() {
        this.close('okay');
    }

    renderedCallback() {
        this.initFlowConfigurations();
    }
    initFlowConfigurations() {
        getFlowConfigurations({}).then( result => {
            this._manageFlow = result['Manage_Commitment_Schedules'];
            this._updateFlow = result['Update_Commitment_Schedule'];
            this._designationFlow = 'frops_flow__ManageGiftDesignations';
            this.loading = false;
        }).catch (error => {
            // TODO: give an meaningfull error 
        });
    }
    handleCancel() {
        this.close('cancel');
    }
    get action() {
        switch (this.quickActionAPIName ) {
            case 'FinDock_update_paymentmethod':
                return 'UpdatePaymentMethod';
            case 'FinDocok_upgrade_downgrade':
                return '';
            default:
                return '';
        }
    }
    
    get flowName() {
        switch ( this.quickActionAPIName ) {
            case 'FinDock_upgrade_downgrade':
                return this._manageFlow;
            case 'FinDock_update_paymentmethod':
                return this._updateFlow;
            case 'designation':
                return this._designationFlow;
            default:
                return this._manageFlow;
        }
    }

    handleStatusChange(event) {
        if (event.detail.status === 'FINISHED') {
            this.handleConfirm();
        }
    }

    get inputVariables() {
        if ( this.quickActionAPIName == 'FinDock_update_paymentmethod' ) {
            return [
                {
                    name: 'recordId',
                    type: 'String',
                    value: this.commitmentId,
                },
                {
                    name: 'action',
                    type: 'String',
                    value: this.action
                }
            ];
        }else {
            return [
                {
                    name: 'recordId',
                    type: 'String',
                    value: this.commitmentId,
                }
            ];
        }
    }

}