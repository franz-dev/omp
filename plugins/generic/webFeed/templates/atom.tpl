{**
 * plugins/generic/webFeed/templates/atom.tpl
 *
 * Copyright (c) 2014-2021 Simon Fraser University
 * Copyright (c) 2003-2021 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * Atom feed template
 *
 *}
<?xml version="1.0" encoding="{$defaultCharset|escape}"?>
<feed xmlns="http://www.w3.org/2005/Atom">
	{* required elements *}
	<id>{url page="issue" op="feed"}</id>
	<title>{$currentPress->getLocalizedName()|escape:"html"|strip}</title>

	{assign var=latestDate value=0}
	{foreach from=$submissions item=submission}
		{if $latestDate < $submission->getLastModified()}
			{assign var=latestDate value=$submission->getLastModified()}
		{/if}
	{/foreach}
	<updated>{$latestDate|date_format:"%Y-%m-%dT%T%z"|regex_replace:"/00$/":":00"}</updated>

	{* recommended elements *}
	{if $currentPress->getSetting('contactName')}
		<author>
			<name>{$currentPress->getSetting('contactName')|strip|escape:"html"}</name>
			{if $currentPress->getSetting('contactEmail')}
			<email>{$currentPress->getSetting('contactEmail')|strip|escape:"html"}</email>
			{/if}
		</author>
	{/if}

	<link rel="alternate" href="{url press=$currentPress->getPath()}" />
	<link rel="self" type="application/atom+xml" href="{url page="feed" op="atom"}" />

	{* optional elements *}

	{* <category/> *}
	{* <contributor/> *}

	<generator uri="https://pkp.sfu.ca/omp/" version="{$ompVersion|escape}">Open Monograph Press</generator>
	{if $currentPress->getLocalizedDescription()}
		{assign var="description" value=$currentPress->getLocalizedDescription()}
	{elseif $currentPress->getLocalizedSetting('searchDescription')}
		{assign var="description" value=$currentPress->getLocalizedSetting('searchDescription')}
	{/if}

	<subtitle type="html">{$description|strip|escape:"html"}</subtitle>

	{foreach from=$submissions item=submission key=sectionId}
		<entry>
			{* required elements *}
			<id>{url page="catalog" op="book" path=$submission->getId()}</id>
			<title>{$submission->getLocalizedTitle()|strip|escape:"html"}</title>
			<updated>{$submission->getLastModified()|date_format:"%Y-%m-%dT%T%z"|regex_replace:"/00$/":":00"}</updated>

			{* recommended elements *}

			{foreach from=$submission->getCurrentPublication()->getData('authors') item=author name=authorList}
				<author>
					<name>{$author->getFullName(false)|strip|escape:"html"}</name>
					{if $author->getEmail()}
						<email>{$author->getEmail()|strip|escape:"html"}</email>
					{/if}
				</author>
			{/foreach}{* authors *}

			<link rel="alternate" href="{url page="catalog" op="book" path=$submission->getId()}" />

			{if $submission->getLocalizedAbstract()}
				<summary type="html" xml:base="{url page="catalog" op="book" path=$submission->getId()}">{$submission->getLocalizedAbstract()|strip|escape:"html"}</summary>
			{/if}

			{* optional elements *}
			{* <category/> *}
			{* <contributor/> *}

			{if $submission->getDatePublished()}
				<published>{$submission->getDatePublished()|date_format:"%Y-%m-%dT%T%z"|regex_replace:"/00$/":":00"}</published>
			{/if}

			{* <source/> *}
			<rights>{translate|escape key="submission.copyrightStatement" copyrightYear=$submission->getCopyrightYear() copyrightHolder=$submission->getLocalizedCopyrightHolder()}</rights>
		</entry>
	{/foreach}{* submissions *}
</feed>
