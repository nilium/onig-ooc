include oniguruma
use oniguruma

CaptureTreeNode: cover from OnigCaptureTreeNode {
    group, beg, end, allocated, num_childs: extern Int
    children: extern(childs) This[]
}

Encoding: cover from OnigEncoding {
    ASCII: static extern(ONIG_ENCODING_ASCII) const This
    ISO_8859_1: static extern(ONIG_ENCODING_ISO_8859_1) const This
    ISO_8859_2: static extern(ONIG_ENCODING_ISO_8859_2) const This
    ISO_8859_3: static extern(ONIG_ENCODING_ISO_8859_3) const This
    ISO_8859_4: static extern(ONIG_ENCODING_ISO_8859_4) const This
    ISO_8859_5: static extern(ONIG_ENCODING_ISO_8859_5) const This
    ISO_8859_6: static extern(ONIG_ENCODING_ISO_8859_6) const This
    ISO_8859_7: static extern(ONIG_ENCODING_ISO_8859_7) const This
    ISO_8859_8: static extern(ONIG_ENCODING_ISO_8859_8) const This
    ISO_8859_9: static extern(ONIG_ENCODING_ISO_8859_9) const This
    ISO_8859_10: static extern(ONIG_ENCODING_ISO_8859_10) const This
    ISO_8859_11: static extern(ONIG_ENCODING_ISO_8859_11) const This
    ISO_8859_13: static extern(ONIG_ENCODING_ISO_8859_13) const This
    ISO_8859_14: static extern(ONIG_ENCODING_ISO_8859_14) const This
    ISO_8859_15: static extern(ONIG_ENCODING_ISO_8859_15) const This
    ISO_8859_16: static extern(ONIG_ENCODING_ISO_8859_16) const This
    UTF8: static extern(ONIG_ENCODING_UTF8) const This
    UTF16_BE: static extern(ONIG_ENCODING_UTF16_BE) const This
    UTF16_LE: static extern(ONIG_ENCODING_UTF16_LE) const This
    UTF32_BE: static extern(ONIG_ENCODING_UTF32_BE) const This
    UTF32_LE: static extern(ONIG_ENCODING_UTF32_LE) const This
    EUC_JP: static extern(ONIG_ENCODING_EUC_JP) const This
    EUC_TW: static extern(ONIG_ENCODING_EUC_TW) const This
    EUC_KR: static extern(ONIG_ENCODING_EUC_KR) const This
    EUC_CN: static extern(ONIG_ENCODING_EUC_CN) const This
    SJIS: static extern(ONIG_ENCODING_SJIS) const This
    KOI8_R: static extern(ONIG_ENCODING_KOI8_R) const This
    CP1251: static extern(ONIG_ENCODING_CP1251) const This
    BIG5: static extern(ONIG_ENCODING_BIG5) const This
    GB18030: static extern(ONIG_ENCODING_GB18030) const This
}

Option: cover from UInt {
    DEFAULT: static extern(ONIG_OPTION_DEFAULT) const This
    NONE: static extern(ONIG_OPTION_NONE) const This
    IGNORECASE: static extern(ONIG_OPTION_IGNORECASE) const This
    EXTEND: static extern(ONIG_OPTION_EXTEND) const This
    MULTILINE: static extern(ONIG_OPTION_MULTILINE) const This
    SINGLELINE: static extern(ONIG_OPTION_SINGLELINE) const This
    FIND_LONGEST: static extern(ONIG_OPTION_FIND_LONGEST) const This
    FIND_NOT_EMPTY: static extern(ONIG_OPTION_FIND_NOT_EMPTY) const This
    NEGATE_SINGLELINE: static extern(ONIG_OPTION_NEGATE_SINGLELINE) const This
    DONT_CAPTURE_GROUP: static extern(ONIG_OPTION_DONT_CAPTURE_GROUP) const This
    CAPTURE_GROUP: static extern(ONIG_OPTION_CAPTURE_GROUP) const This
    NOTBOL: static extern(ONIG_OPTION_NOTBOL) const This
    NOTEOL: static extern(ONIG_OPTION_NOTEOL) const This
    POSIX_REGION: static extern(ONIG_OPTION_POSIX_REGION) const This
    MAXBIT: static extern(ONIG_OPTION_MAXBIT) const This
}

Syntax: cover from OnigSyntaxType* {
    ASIS: static extern(ONIG_SYNTAX_ASIS) const This
    POSIX_BASIC: static extern(ONIG_SYNTAX_POSIX_BASIC) const This
    POSIX_EXTENDED: static extern(ONIG_SYNTAX_POSIX_EXTENDED) const This
    EMACS: static extern(ONIG_SYNTAX_EMACS) const This
    GREP: static extern(ONIG_SYNTAX_GREP) const This
    GNU_REGEX: static extern(ONIG_SYNTAX_GNU_REGEX) const This
    JAVA: static extern(ONIG_SYNTAX_JAVA) const This
    PERL: static extern(ONIG_SYNTAX_PERL) const This
    PERL_NG: static extern(ONIG_SYNTAX_PERL_NG) const This
    RUBY: static extern(ONIG_SYNTAX_RUBY) const This
    DEFAULT: static extern(ONIG_SYNTAX_DEFAULT) const This
}

ErrorInfo: cover from OnigErrorInfo {
    encoding: extern(enc) Encoding
    par: extern String
    parEnd: extern(par_end) String
}

ONIG_NORMAL,
ONIG_NREGION,
ONIG_MAX_BACKREF_NUM,
ONIG_MAX_REPEAT_NUM,
ONIG_MAX_MULTI_BYTE_RANGES_NUM,
ONIG_MAX_ERROR_MESSAGE_LEN: extern const Int

Oniguruma: cover {
    init: static extern(onig_init) func -> Int
    errorCodeToString: static extern(onig_error_code_to_str) func (buf: Pointer, code: Int, ...) -> Int
    setWarningFunction: static extern(onig_set_warn_func) func (Func)
    setVerboseWarningFunction: static extern(onig_set_verb_warn_func) func (Func)
    newRegexp: static extern(onig_new) func (Regexp*, Pointer, Pointer, Option, Encoding, Syntax, ErrorInfo*) -> Int
}

RegionStruct: cover from OnigRegion {
    allocated, num_regs: extern Int
    beg, end: extern Int*
}

Region: cover from RegionStruct* {
    new: static extern(onig_region_new) func -> This
    free: extern(onig_region_free) func (freeSelf: Int)
    copyFrom: extern(onig_region_copy) func (from_: This)
    clear: extern(onig_region_clear) func
    resize: extern(onig_region_resize) func (n: Int) -> Int
    
    beginning: func -> Int {
        this@ beg@
    }
    
    ending: func -> Int {
        this@ end@
    }
}

Regexp: cover from OnigRegex {
    /*
    p: extern UChar*
    used, alloc: extern UInt
    state, num_mem, num_repeat, num_null_check, num_comb_exp_check, num_call: extern Int
    capture_history, bt_mem_start, bt_mem_end: extern UInt
    stack_pop_level, repeat_range_alloc: extern Int
    repeat_range: extern Pointer
    // ...
    */
    
    new: static func (pattern: String, option: Option, encoding: Encoding, syntax: Syntax, info: ErrorInfo*) -> This {
        p := pattern as UChar*
        r: Regexp
        if (Oniguruma newRegexp(r&, p, p + (pattern length()), option, encoding, syntax, info) == ONIG_NORMAL) {
            return r
        }
        
        return null
    }
    
    new: static func ~simple (pattern: String) -> This {
        This new(pattern, Option DEFAULT, Encoding ASCII, Syntax DEFAULT, null)
    }
    
    free: extern(onig_free) func
    
    search: extern(onig_search) func (str, end, start, range: UChar*, region: Region, option: Option) -> Int
    
    search: func ~simple (str: String) -> Int {
        this search(str, null)
    }
    
    search: func ~simpleWithRegion (str: String, r: Region) -> Int {
        p := str as UChar*
        this search(p, p + str length(), p, p + str length(), r, Option NONE)
    }
    
    matches: extern(onig_match) func (str, end, at: UChar*, region: Region, option: Option) -> Int
    
    matches: func ~simple (str: String) -> Int {
        matches(str, null)
    }
    
    matches: func ~simpleWithRegion (str: String, r: Region) -> Int {
        p := str as UChar*
        this matches(p, p + str length(), p, r, Option NONE)
    }
    
    nameToGroupNumbers: extern(onig_name_to_group_numbers) func (name, name_end: UChar*, num_list: Int*) -> Int
    nameToBackrefNumber: extern(onig_name_to_backref_number) func (name, name_end: UChar*, region: Region) -> Int
    foreachName: extern(onig_foreach_name) func (fn: Func, arg: Pointer) -> Int
    numberOfNames: extern(onig_number_of_names) func -> Int
    numberOfCaptures: extern(onig_number_of_captures) func -> Int
    numberOfCaptureHistories: extern(onig_number_of_capture_histories) func -> Int
    nonameGroupCaptureIsActive: extern(onig_noname_group_capture_is_active) func -> Int
}
