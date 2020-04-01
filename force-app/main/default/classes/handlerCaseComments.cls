public class handlerCaseComments{
    public static void mapCaseComments(List<CaseComment> currentCaseComments){
        Set<Id> childCaseIds = new Set<Id>();
       	List<CaseComment> CaseCommentListToInsert = new List<CaseComment>();
        for(CaseComment CaseCommentobj: currentCaseComments){
            if(CaseCommentobj.ParentId != null){
                childCaseIds.add(CaseCommentobj.ParentId);
            }
        }
        //fetching child cases
        Map<Id,Case> childCaseMap = new Map<Id,Case>([SELECT Id,ParentId FROM Case WHERE Id IN : childCaseIds 
                                                      AND ParentId != null]);
            if(childCaseMap != null){
                    for(CaseComment caseCommentObj : currentCaseComments){
                        //ParentId of CaseComment
                        Case caseDetails =  childCaseMap.get(caseCommentObj.ParentId);
                        CaseComment CaseCommentParentcase = new CaseComment();
                        CaseCommentParentcase.ParentId = caseDetails.parentId ;	//ParentId of Child Case
                        CaseCommentParentcase.IsPublished = caseCommentObj.IsPublished ;
                        CaseCommentParentcase.CommentBody = caseCommentObj.CommentBody ;
                        CaseCommentListToInsert.add(CaseCommentParentcase);
                    }
                insert CaseCommentListToInsert;
            }
        }
    }