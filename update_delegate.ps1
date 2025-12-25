$file = "d:\Mockup HRM\delegate_v1.html"
$content = Get-Content $file -Raw

# Helper function to add custom checkbox before a multi-select wrapper
function Add-CustomCheckbox {
    param($label, $defaultText)
    
    $pattern = "(<label class=`"block text-sm font-medium text-gray-700 mb-2`">\s*$label <span class=`"text-red-500`">\*</span>\s*</label>)\s*(<div class=`"relative multi-select-wrapper`">)"
    
    $replacement = "`$1`n                            <div class=`"mb-2`">`n                                <label class=`"flex items-center cursor-pointer`">`n                                    <input type=`"checkbox`" class=`"custom-select-checkbox w-4 h-4 text-blue-500 mr-2`" onchange=`"toggleCustomSelect(this)`">`n                                    <span class=`"text-sm text-gray-600`">Custom (Tùy chọn)</span>`n                                </label>`n                            </div>`n                            <div class=`"relative multi-select-wrapper`" data-default-text=`"$defaultText`">"
    
    return $content -replace $pattern, $replacement
}

# Step 1: Add custom checkbox for Quy trình
$content = $content -replace '(<label class="block text-sm font-medium text-gray-700 mb-2">\s*Quy trình được ủy quyền <span class="text-red-500">\*</span>\s*</label>)\s*<div class="relative multi-select-wrapper">', '$1<div class="mb-2"><label class="flex items-center cursor-pointer"><input type="checkbox" class="custom-select-checkbox w-4 h-4 text-blue-500 mr-2" onchange="toggleCustomSelect(this)"><span class="text-sm text-gray-600">Custom (Tùy chọn)</span></label></div><div class="relative multi-select-wrapper" data-default-text="All Workflow">'

# Step 2: Update button for Quy trình - change bg-white to bg-gray-100, cursor-pointer to cursor-not-allowed, add disabled, change text
$content = $content -replace '(<div class="relative multi-select-wrapper" data-default-text="All Workflow">)\s*<button type="button" class="multi-select-trigger w-full px-3 py-1\.5 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 bg-white cursor-pointer text-left flex items-center justify-between" onclick="toggleMultiSelect\(this\)">\s*<span class="text-gray-500">\+ Chọn quy trình</span>', '$1<button type="button" class="multi-select-trigger w-full px-3 py-1.5 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 bg-gray-100 cursor-not-allowed text-left flex items-center justify-between" onclick="toggleMultiSelect(this)" disabled><span class="text-gray-700 font-medium">All Workflow</span>'

# Step 3: Add custom checkbox for Task
$content = $content -replace '(<label class="block text-sm font-medium text-gray-700 mb-2">\s*Task được ủy quyền <span class="text-red-500">\*</span>\s*</label>)\s*<div class="relative multi-select-wrapper">', '$1<div class="mb-2"><label class="flex items-center cursor-pointer"><input type="checkbox" class="custom-select-checkbox w-4 h-4 text-blue-500 mr-2" onchange="toggleCustomSelect(this)"><span class="text-sm text-gray-600">Custom (Tùy chọn)</span></label></div><div class="relative multi-select-wrapper" data-default-text="All Task">'

# Step 4: Update button for Task
$content = $content -replace '(<div class="relative multi-select-wrapper" data-default-text="All Task">)\s*<button type="button" class="multi-select-trigger w-full px-3 py-1\.5 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 bg-white cursor-pointer text-left flex items-center justify-between" onclick="toggleMultiSelect\(this\)">\s*<span class="text-gray-500">\+ Chọn task</span>', '$1<button type="button" class="multi-select-trigger w-full px-3 py-1.5 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 bg-gray-100 cursor-not-allowed text-left flex items-center justify-between" onclick="toggleMultiSelect(this)" disabled><span class="text-gray-700 font-medium">All Task</span>'

# Step 5: Add custom checkbox for Department
$content = $content -replace '(<label class="block text-sm font-medium text-gray-700 mb-2">\s*Department <span class="text-red-500">\*</span>\s*</label>)\s*<div class="relative multi-select-wrapper">', '$1<div class="mb-2"><label class="flex items-center cursor-pointer"><input type="checkbox" class="custom-select-checkbox w-4 h-4 text-blue-500 mr-2" onchange="toggleCustomSelect(this)"><span class="text-sm text-gray-600">Custom (Tùy chọn)</span></label></div><div class="relative multi-select-wrapper" data-default-text="All Department">'

# Step 6: Update button for Department
$content = $content -replace '(<div class="relative multi-select-wrapper" data-default-text="All Department">)\s*<button type="button" class="multi-select-trigger w-full px-3 py-1\.5 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 bg-white cursor-pointer text-left flex items-center justify-between" onclick="toggleMultiSelect\(this\)">\s*<span class="text-gray-500">\+ Chọn department</span>', '$1<button type="button" class="multi-select-trigger w-full px-3 py-1.5 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 bg-gray-100 cursor-not-allowed text-left flex items-center justify-between" onclick="toggleMultiSelect(this)" disabled><span class="text-gray-700 font-medium">All Department</span>'

# Save the modified content
$content | Set-Content $file -NoNewline

Write-Host "File updated successfully!"
