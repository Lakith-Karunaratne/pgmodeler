# Template code for data dictionary generation
# CAUTION: Do not modify this file unless you know what you are doing.
# Code generation can be broken if incorrect changes are made.

%set {spc} $br [ ]

%if {split} %then
	[<html>
	<head>
	<meta charset="utf-8">
	<title>Data dictionary generated by pgModeler</title>
	<link rel="stylesheet" type="text/css" href="styles.css">
	</head>
	<body>]
%end

$br [<h2>Data dictionary index</h2>]

{spc} <ul $sp id="index">
{spc} <li><strong>[Database: ]</strong> {name}</strong>

%if {table} %then
	{spc} <li><br/><strong>Tables</strong>
	{spc} <ul>
	{table}
	{spc} </ul>
	{spc} </li>
%end

%if {foreigntable} %then
	{spc} <li><br/><strong>[Foreign tables]</strong>
	{spc} <ul>
	{foreigntable}
	{spc} </ul>
	{spc} </li>
%end

%if {view} %then
	{spc} <li><br/><strong>Views</strong>
	{spc} <ul>
	{view}
	{spc} </ul>
	{spc} </li>
%end

{spc} </ul>
$br

%if {split} %then

	[<footer>
	Generated by <a href="https://pgmodeler.io"> PostgreSQL Database Modeler - pgModeler</a><br/>
	Copyright © 2006 - ] {year} [ Raphael Araújo e Silva
	</footer> ]

	</body> $br
	</html>
%end