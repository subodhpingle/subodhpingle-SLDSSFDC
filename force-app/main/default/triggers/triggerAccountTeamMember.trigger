trigger triggerAccountTeamMember on AccountTeamMember (after insert) {
	handlerAccountTeamMember.notifyUser(Trigger.New);
}