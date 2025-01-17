{**
 * templates/submission/form/step1.tpl
 *
 * Copyright (c) 2014-2021 Simon Fraser University
 * Copyright (c) 2003-2021 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * Step 1 of author monograph submission.
 *}
 {if $currentContext->getData('disableSubmissions')}
	<notification>
		{translate key="manager.setup.disableSubmissions.notAccepting"}
	</notification>
{else}
	{capture assign="additionalFormContent1"}
		<!-- Submission Type -->
		{fbvFormSection list="true" label="submission.workflowType" description="submission.workflowType.description"}
			{fbvElement type="radio" name="workType" id="isEditedVolume-0" value=\APP\submission\Submission::WORK_TYPE_AUTHORED_WORK checked=$workType|compare:\APP\submission\Submission::WORK_TYPE_EDITED_VOLUME:false:true label="submission.workflowType.authoredWork" disabled=$submissionId}{* "checked" is inverted; matches empty and WORK_TYPE_AUTHORED_WORK *}
			{fbvElement type="radio" name="workType" id="isEditedVolume-1" value=\APP\submission\Submission::WORK_TYPE_EDITED_VOLUME checked=$workType|compare:\APP\submission\Submission::WORK_TYPE_EDITED_VOLUME label="submission.workflowType.editedVolume" disabled=$submissionId}
		{/fbvFormSection}
	{/capture}
	{capture assign="additionalFormContent2"}
		{include file="submission/form/series.tpl"}
	{/capture}

	{include file="core:submission/form/step1.tpl"}
{/if}
