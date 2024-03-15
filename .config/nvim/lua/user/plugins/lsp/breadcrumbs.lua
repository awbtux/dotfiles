local breadcrumbs_status_ok, breadcrumbs = pcall(require, "breadcrumbs")
if not breadcrumbs_status_ok then
    return
end

breadcrumbs.setup()
