public with sharing class GiftCommitmentSetupController {
    @AuraEnabled
    public static CommitmentInformation getCommitmentInformation( Id commitmentId ) {
        GiftCommitment commitment = [select id, (select id from GiftCommitmentSchedules limit 1) , (select id from GiftDefaultDesignationParentRecords limit 1) from GiftCommitment where Id =:commitmentId ];

        CommitmentInformation returnObject = new CommitmentInformation(commitment);
        return returnObject;
    }

    public class CommitmentInformation {
        @AuraEnabled
        public boolean hasCommitmentSchedule {get;set;}
        @AuraEnabled
        public boolean hasDesignationRecords {get;set;}

        public CommitmentInformation ( GiftCommitment commitment ) {
            this.hasCommitmentSchedule = commitment.GiftCommitmentSchedules.size() > 0;
            this.hasDesignationRecords = commitment.GiftDefaultDesignationParentRecords.size() > 0;
        }
    }
}