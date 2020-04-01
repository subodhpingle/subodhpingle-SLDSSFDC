trigger triggeLead on Lead (before insert) {
	handlerLead.restrictLeadFirstName(Trigger.New);
}