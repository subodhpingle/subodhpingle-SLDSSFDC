<aura:application access="global" extends="ltng:outApp" >
    <aura:attribute name="myRecordId" type="String" description="Record to which the files should be attached"/>
    <h1>Test File Upload</h1>
    <lightning:fileUpload label="Attach receipt" multiple="true" accept=".pdf, .png, .jpg" recordId="0017F000006QniZQAS" onuploadfinished="{!c.handleUploadFinished}" />
</aura:application>