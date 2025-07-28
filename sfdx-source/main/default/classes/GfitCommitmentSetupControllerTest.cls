@IsTest
public with sharing class GfitCommitmentSetupControllerTest {
    public static testMethod void commitmentWithoutSchedulesAndDesignations() {
        // given
        Account donor = new Account (
            RecordTypeId = getPersonAccountrecordTypeId(),
            FirstName = 'first',
            LastName = 'last'
        );

        insert donor;

        GiftCommitment commitment = new GiftCommitment(
            Name = 'Testing',
            DonorId = donor.Id,
            Description = 'Donation',
            Status = 'Active',
            ScheduleType = 'Recurring'
        );

        insert commitment;

        // when
        GiftCommitmentSetupController.CommitmentInformation info = GiftCommitmentSetupController.getCommitmentInformation(commitment.Id);

        // then
        Assert.areEqual(info.hasCommitmentSchedule, false);
        Assert.areEqual(info.hasDesignationRecords, false);
    }

    public static testMethod void commitmentWithoutSchedules() {
        // given
        GiftDesignation designation = new GiftDesignation(
            Name = 'default',
            IsActive = true,
            IsDefault = true
        );
        insert designation;

        Account donor = new Account (
            RecordTypeId = getPersonAccountrecordTypeId(),
            FirstName = 'first',
            LastName = 'last'
        );

        insert donor;

        GiftCommitment commitment = new GiftCommitment(
            Name = 'Testing',
            Description = 'Donation',
            DonorId = donor.Id,
            Status = 'Active',
            ScheduleType = 'Recurring'
        );
        insert commitment;

        GiftDefaultDesignation assignment = new GiftDefaultDesignation(
            GiftDesignationId = designation.Id,
            ParentRecordId = commitment.Id,
            AllocatedPercentage = 100
        );
        insert assignment;
        // when
        GiftCommitmentSetupController.CommitmentInformation info = GiftCommitmentSetupController.getCommitmentInformation(commitment.Id);

        // then
        Assert.areEqual(info.hasCommitmentSchedule, false);
        Assert.areEqual(info.hasDesignationRecords, true);
    }

    public static testMethod void commitmentWithAllInformation() {
        // given
        GiftDesignation designation = new GiftDesignation(
            Name = 'default',
            IsActive = true,
            IsDefault = true
        );
        insert designation;

        Account donor = new Account (
            RecordTypeId = getPersonAccountrecordTypeId(),
            FirstName = 'first',
            LastName = 'last'
        );

        insert donor;

        GiftCommitment commitment = new GiftCommitment(
            Name = 'Testing',
            Description = 'Donation',
            DonorId = donor.Id,
            Status = 'Active',
            ScheduleType = 'Recurring'
        );
        insert commitment;

        GiftCommitmentSchedule schedule = new GiftCommitmentSchedule(
            GiftCommitmentId = commitment.Id,
            TransactionInterval = 1,
            TransactionAmount = 5,
            StartDate = date.today(),
            TransactionPeriod = 'Monthly',
            Type = 'CreateTransactions',
            TransactionDay = '1'
        );
        insert schedule;

        GiftDefaultDesignation assignment = new GiftDefaultDesignation(
            GiftDesignationId = designation.Id,
            ParentRecordId = commitment.Id,
            AllocatedPercentage = 100
        );
        insert assignment;
        
        // when
        GiftCommitmentSetupController.CommitmentInformation info = GiftCommitmentSetupController.getCommitmentInformation(commitment.Id);

        // then
        Assert.areEqual(info.hasCommitmentSchedule, true);
        Assert.areEqual(info.hasDesignationRecords, true);
    }


    public static Id getPersonAccountrecordTypeId() {
        RecordType rt = [select id from RecordType where IsPersonType = true limit 1];
        return rt.Id;
    }
}