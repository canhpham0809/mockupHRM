# JIRA: Xây dựng màn hình Delegate (Ủy quyền tác vụ)

## I. TỔNG QUAN
Xây dựng 2 màn hình quản lý ủy quyền tác vụ: danh sách ủy quyền và form tạo/chỉnh sửa ủy quyền.

---

## II. MÀN HÌNH 1: DANH SÁCH ỦY QUYỀN (delegate_list.html)

### A. CHỨC NĂNG CHÍNH
- Hiển thị danh sách tất cả ủy quyền đang có trên hệ thống
- Tìm kiếm và lọc theo: Người ủy quyền, Người được ủy quyền, Trạng thái
- Phân trang 10 bản ghi/trang
- Xem chi tiết, chỉnh sửa, xóa ủy quyền

### B. DANH SÁCH CỘT TRONG BẢNG
| Cột | Loại | Ghi chú |
|-----|------|---------|
| STT | Text | Thứ tự bản ghi |
| Người ủy quyền | Text | Chỉ hiển thị tên (không chức vụ) |
| Người được ủy quyền | Text | Chỉ hiển thị tên (không chức vụ) |
| Thời gian ủy quyền | Text | Format: `DD/MM/YYYY - DD/MM/YYYY` hoặc "Vô thời hạn" |
| Quy trình | Text | Danh sách quy trình (mỗi dòng một item) |
| Trạng thái | Badge | Còn hạn (xanh) / Hết hạn (đỏ) / Vô thời hạn (xanh nhạt) |
| Ngày tạo | Date | Format: `DD/MM/YYYY` |
| Người cập nhật | Text | Tên người cập nhật cuối cùng |
| Thời gian cập nhật | Date | Format: `DD/MM/YYYY` |

### C. LOGIC TRẠNG THÁI
```
- Nếu timeType = "infinite" → Badge "Vô thời hạn" (màu xanh nhạt)
- Nếu timeType = "finite" AND endDate < ngày hiện tại → Badge "Hết hạn" (màu đỏ)
- Nếu timeType = "finite" AND endDate >= ngày hiện tại → Badge "Còn hạn" (màu xanh)
```

### D. FILTER
**Filter theo:**
1. **Người ủy quyền**: Search text (không phân biệt hoa/thường)
2. **Người được ủy quyền**: Search text (không phân biệt hoa/thường)
3. **Trạng thái**: Dropdown (Tất cả / Còn hạn / Hết hạn / Vô thời hạn)

**Validate:** Ít nhất một field được nhập mới thực hiện lọc

### E. ACTION
- **Tạo mới**: Button ở header → Chuyển sang delegate_v2.html
- **Xóa**: Popup xác nhận → Xóa khỏi localStorage
- Lưu dữ liệu từ delegate_v2.html vào localStorage

### F. DATA STRUCTURE
```javascript
{
  id: number,
  delegator: string,           // Tên người ủy quyền
  delegatee: string,           // Tên người được ủy quyền
  timeType: "finite|infinite",
  startDate: "YYYY-MM-DDTHH:MM" | null,
  endDate: "YYYY-MM-DDTHH:MM" | null,
  workflows: [string],         // Danh sách quy trình
  description: string,         // Mô tả
  active: boolean,            // Kích hoạt hay không
  createdDate: "YYYY-MM-DDTHH:MM:SS",
  updatedDate: "YYYY-MM-DDTHH:MM:SS",
  updatedBy: string           // Tên người cập nhật
}
```

---

## III. MÀN HÌNH 2: FORM TẠO/CHỈNH SỬA ỦY QUYỀN (delegate_v2.html)

### A. CHỨC NĂNG CHÍNH
- Tạo mới một ủy quyền hoặc chỉnh sửa ủy quyền hiện có
- Có thể thêm nhiều người được ủy quyền trong 1 lần (multi-card)
- Mỗi card là 1 người được ủy quyền với các quy trình riêng

---

### B. DANH SÁCH CÁC FIELD

#### PHẦN 1: THÔNG TIN CHUNG (Trên cùng form)

| Field | Type | Validate | Logic/Ghi chú |
|-------|------|----------|---------------|
| Người ủy quyền | Dropdown Select | Bắt buộc | Hiển thị "Tên - Chức vụ" nhưng lưu chỉ "Tên" |

---

#### PHẦN 2: DANH SÁCH NGƯỜI ĐƯỢC ỦY QUYỀN (CARDS - Lặp lại)

**Card có các field sau:**

| # | Field | Type | Validate | Logic/Ghi chú |
|---|-------|------|----------|---------------|
| 1 | Người được ủy quyền | Dropdown Select | Bắt buộc | Ẩn người đã chọn ở card khác (khi thêm mới) |
| 2 | Thời gian ủy quyền | Radio Button (2 lựa chọn) | Bắt buộc | "Có thời hạn" (default) hoặc "Vô thời hạn" |
| 2a | Từ ngày - Đến ngày | DateTime input (2 fields) | Bắt buộc nếu "Có thời hạn" | Hiển thị khi chọn "Có thời hạn"; Default từ ngày = ngày hiện tại; Đến ngày >= Từ ngày |
| 3 | File ủy quyền | Upload (Drag & Drop) | Optional | Accept: PDF, DOC, DOCX, PNG, JPG (max 5MB) |
| 4 | Mô tả | Textarea | Optional | Rows: 3; Placeholder: "Nhập mô tả thêm về ủy quyền..." |
| 5 | Kích hoạt | Checkbox | N/A | Default: Checked ✓ |
| 6 | Phạm vi ủy quyền | Checkbox toggle + Table | Bắt buộc | Default unchecked: Hiển thị "All Workflow • All Task"; Checked: Hiển thị table với button "+ Thêm dòng" |

**Phạm vi ủy quyền - Table detail:**
- Click "+ Thêm dòng" → Mở modal
- Mỗi dòng = 1 Workflow + Task + Dynamic Fields
- Click vào row để edit
- Nút Xóa ở cuối dòng

| Column | Type | Validate |
|--------|------|----------|
| Workflow | Text | - |
| Task | Text (danh sách tasks) | - |
| Dynamic Fields | Text (danh sách) | - |
| Action | Xóa button | - |

---

#### MODAL: Thêm/Sửa dòng Workflow/Task

| # | Field | Type | Validate | Logic/Ghi chú |
|---|-------|------|----------|---------------|
| 1 | Workflow | Dropdown Select | Bắt buộc | Auto-select "All Tasks" khi chọn WF; Ẩn WF đã chọn (khi thêm mới) |
| 2 | Task | Checkbox list + "All Tasks" | Bắt buộc ≥1 | Default: All Tasks checked; Danh sách từ Workflow mapping |
| 3 | Dynamic Fields | Multi-select Dropdown | Optional | Phụ thuộc Workflow (xem Workflow mapping); Mỗi field là checkbox dropdown |

**Modal Buttons:**
- "Hủy" - Đóng modal
- "Xóa" - Xóa dòng (hiển thị khi edit mode, ẩn khi add mode)
- "Thêm" / "Cập nhật" - Lưu dòng

---

#### PHẦN 3: BUTTONS TẠI FOOTER CỦA MỖI CARD

| Button | Action | Condition |
|--------|--------|-----------|
| Lưu | Lưu dữ liệu card | Luôn có sẵn |
| Xóa | Xóa card hiện tại | Phải có ≥1 card; Confirm trước khi xóa |

---

#### PHẦN 4: BUTTONS TẠI BOTTOM OF FORM

| Button | Action | Validate |
|--------|--------|----------|
| Đóng | Quay lại danh sách | Confirm nếu có thay đổi chưa lưu |
| Lưu và Quay lại | Lưu tất cả vào localStorage + Redirect | Validate toàn bộ form (xem mục E) |

---

### C. CARD STRUCTURE

```
┌─────────────────────────────────────────────┐
│ 👤 Người được ủy quyền [Dropdown]           │
├─────────────────────────────────────────────┤
│ Thời gian ủy quyền *                        │
│ ✓ Có thời hạn        ○ Vô thời hạn         │
│ [Từ ngày] - [Đến ngày]  (ẩn nếu vô thời hạn) │
├─────────────────────────────────────────────┤
│ File ủy quyền                               │
│ [Upload Area - Drag & Drop]                 │
├─────────────────────────────────────────────┤
│ Mô tả                                       │
│ [Textarea - 3 rows]                         │
├─────────────────────────────────────────────┤
│ ☑ Kích hoạt                                 │
├─────────────────────────────────────────────┤
│ Phạm vi ủy quyền *                          │
│ ☐ Custom (Tùy chọn)  All Workflow • All Task │
│                                              │
│ [Table - Hiển thị khi checked]               │
│ | Workflow | Task | Dynamic Fields | Xóa |  │
│ | ...      | ...  | ...            | [X] |  │
│ [+ Thêm dòng]                                │
├─────────────────────────────────────────────┤
│ [Lưu]  [Xóa]                                │
└─────────────────────────────────────────────┘
```

---

### D. WORKFLOW MAPPING

#### Dynamic Fields Mapping:
```javascript
{
  "1": ["Department", "Office"],           // Quy trình phê duyệt đơn hàng
  "2": ["Department", "Employee Type"],    // Quy trình phê duyệt nghỉ phép
  "3": ["Department", "Office"],           // Quy trình thanh toán hóa đơn
  "4": ["Department"]                      // Quy trình cấp phép nhân viên
}
```

#### Task Mapping:
```javascript
{
  "1": ["1", "2", "3"],      // Workflow 1 → Tasks 1, 2, 3
  "2": ["4", "5", "6"],      // Workflow 2 → Tasks 4, 5, 6
  "3": ["7", "8"],           // Workflow 3 → Tasks 7, 8
  "4": ["9", "10", "11"]     // Workflow 4 → Tasks 9, 10, 11
}
```

#### Dynamic Field Options:
```javascript
{
  "Department": [
    { value: "A4B", label: "A4B" },
    { value: "VNGG", label: "VNGG" },
    { value: "ZPS", label: "ZPS" },
    { value: "VNG_CORP", label: "VNG Corp" }
  ],
  "Office": [
    { value: "VNG_CAMPUS", label: "VNG Campus" },
    { value: "DINH_TIEN_HOANG", label: "Dinh Tien Hoang" },
    { value: "HANOI", label: "Hanoi" }
  ],
  "Employee Type": [
    { value: "FULLTIME", label: "Full-time" },
    { value: "PARTTIME", label: "Part-time" },
    { value: "CONTRACT", label: "Contract" },
    { value: "INTERN", label: "Intern" }
  ]
}
```

---

### E. VALIDATE RULES

**Cấp Form:**
- [ ] Người ủy quyền: Bắt buộc chọn
- [ ] Mỗi card phải có người được ủy quyền
- [ ] Nếu "Có thời hạn": Phải nhập Từ ngày và Đến ngày
- [ ] Nếu "Có thời hạn": Đến ngày >= Từ ngày
- [ ] Phạm vi ủy quyền:
  - Default (All Workflow): Hợp lệ
  - Custom: Phải có ≥1 dòng workflow/task

**Cấp Modal Workflow:**
- [ ] Workflow: Bắt buộc chọn
- [ ] Task: Bắt buộc chọn ≥1 (mặc định All Tasks)
- [ ] Dynamic Fields: Optional

---

### F. SAVE LOGIC

Khi click "Lưu và Quay lại":

```javascript
1. Validate toàn bộ form
2. Tạo object delegation:
   {
     id: auto-increment,
     delegator: extractName(selectedDelegator),
     delegatee: extractName(selectedDelegatee),
     timeType: "finite" | "infinite",
     startDate: fromDate || null,
     endDate: toDate || null,
     workflows: [...workflowList],
     description: descriptionText,
     active: checkboxValue,
     createdDate: new Date().toISOString(),
     updatedDate: new Date().toISOString(),
     updatedBy: extractName(delegator)
   }
3. Lưu vào localStorage["delegationData"]
4. Redirect về delegate_list.html
```

---

### G. EDIT MODE LOGIC

Khi click dòng trong danh sách delegate_list:
1. Query URL parameter `?id=X`
2. Load dữ liệu từ localStorage
3. Pre-fill tất cả field theo dữ liệu
4. Modal title: "Cập Nhật Phạm Vi Ủy Quyền"
5. Modal button: "Cập nhật" (thay vì "Thêm")
6. Thêm button "Xóa" trong modal footer

---

## IV. DATA STORAGE

**Key localStorage**: `delegationData`

**Format**: JSON array của delegation objects

**Example:**
```json
[
  {
    "id": 1,
    "delegator": "Nguyễn Văn A",
    "delegatee": "Phạm Văn D",
    "timeType": "finite",
    "startDate": "2026-01-01T08:00",
    "endDate": "2026-12-31T18:00",
    "workflows": ["Quy trình phê duyệt đơn hàng", "Quy trình thanh toán hóa đơn"],
    "description": "Ủy quyền tạm thời",
    "active": true,
    "createdDate": "2026-01-01T10:00:00",
    "updatedDate": "2026-01-03T14:30:00",
    "updatedBy": "Nguyễn Văn A"
  }
]
```

---

## V. MOCK DATA

Cấu hình 4 workflows và dynamic fields tương ứng:

### Workflows:
1. Quy trình phê duyệt đơn hàng
2. Quy trình phê duyệt nghỉ phép
3. Quy trình thanh toán hóa đơn
4. Quy trình cấp phép nhân viên

### Mapping Workflow → Tasks:
- WF1: Task 1-3 (Kiểm tra xác nhận, Phê duyệt giá, Duyệt toàn bộ)
- WF2: Task 4-6 (Xử lý yêu cầu, Kiểm tra ngày phép, Phê duyệt)
- WF3: Task 7-8 (Xác nhận thanh toán, Kiểm tra chi phí)
- WF4: Task 9-11 (Cấp quyền hệ thống, Tạo email, Giao thiết bị)

### Dynamic Fields Options:
- **Department**: A4B, VNGG, ZPS, VNG_CORP
- **Office**: VNG Campus, Dinh Tien Hoang, Hanoi
- **Employee Type**: Full-time, Part-time, Contract, Intern

---

## VI. ACCEPTANCE CRITERIA

- [ ] Danh sách ủy quyền hiển thị đúng dữ liệu, lọc/tìm kiếm hoạt động
- [ ] Form tạo/chỉnh sửa hỗ trợ multi-card, validate đầy đủ
- [ ] Dữ liệu lưu/load từ localStorage đúng format
- [ ] Trạng thái hiển thị chính xác (Còn hạn/Hết hạn/Vô thời hạn)
- [ ] Thêm/xóa/chỉnh sửa ủy quyền hoạt động đúng
- [ ] Responsive trên mobile (768px+)
- [ ] Validate message hiển thị rõ ràng khi có lỗi

---

**Estimate**: 3-5 days (FE dev)
**Priority**: High
**Assignee**: FE Team
