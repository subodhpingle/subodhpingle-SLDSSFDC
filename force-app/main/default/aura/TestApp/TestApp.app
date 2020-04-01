<aura:application extends="force:slds">
  <!-- Create attribute to store lookup value as a sObject--> 
  <aura:attribute name="selectedLookUpRecords" type="sObject[]" default="[]"/>
 
  <c:reUsableMultiSelectLookup objectAPIName="Employee__c"
                               IconName="standard:Employee__c"
                               lstSelectedRecords="{!v.selectedLookUpRecords}"
                               label="Employee Name"/>
   <!-- here c: is org. namespace prefix-->
</aura:application>