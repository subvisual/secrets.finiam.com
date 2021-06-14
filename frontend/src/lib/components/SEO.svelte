<script>
  export let title;
  export let description;
  export let keywords;
</script>

<title>{title}</title>
<meta name="description" content={description} />
<meta name="keywords" content={keywords} />
<meta content={title} property="og:title" />
<meta content={description} property="og:description" />
<meta content={title} property="twitter:title" />
<meta content={description} property="twitter:description" />
<meta content={title} property="twitter:title" />
<meta content={description} property="twitter:description" />
