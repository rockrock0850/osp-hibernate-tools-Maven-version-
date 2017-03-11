${pojo.getPackageDeclaration()}
// Generated ${date} by Hibernate Tools ${version}

<#assign classbody>
<#assign declarationName = pojo.importType(pojo.getDeclarationName())>/**
 * DAO object for domain model class ${declarationName}.
 * @see ${pojo.getQualifiedDeclarationName()}
 * @author Hibernate Tools
 */
<#if ejb3>
@${pojo.importType("javax.ejb.Stateless")}
</#if>
public interface I${declarationName}DAO {

<#if ejb3>
    @${pojo.importType("javax.persistence.PersistenceContext")} private ${pojo.importType("javax.persistence.EntityManager")} entityManager;
    
    public void persist(${declarationName} transientInstance);
    
    public void remove(${declarationName} persistentInstance);
    
    public ${declarationName} merge(${declarationName} detachedInstance);
    
<#if clazz.identifierProperty?has_content>    
    public ${declarationName} findById( ${pojo.getJavaTypeName(clazz.identifierProperty, jdk5)} id);
</#if>
<#else>    
    protected ${pojo.importType("org.hibernate.SessionFactory")} getSessionFactory();
    
    public void persist(${declarationName} transientInstance);
    
    public void attachDirty(${declarationName} instance);
    
    public void attachClean(${declarationName} instance);
    
    public void delete(${declarationName} persistentInstance);
    
    public ${declarationName} merge(${declarationName} detachedInstance);
    
<#if clazz.identifierProperty?has_content>
    public ${declarationName} findById( ${c2j.getJavaTypeName(clazz.identifierProperty, jdk5)} id);
</#if>
    
<#if clazz.hasNaturalId()>
    public ${declarationName} findByNaturalId(${c2j.asNaturalIdParameterList(clazz)});
</#if>    
<#if jdk5>
    public ${pojo.importType("java.util.List")}<${declarationName}> findByExample(${declarationName} instance);
<#else>
    public ${pojo.importType("java.util.List")} findByExample(${declarationName} instance);
</#if>

<#foreach queryName in cfg.namedQueries.keySet()>
<#if queryName.startsWith(clazz.entityName + ".")>
<#assign methname = c2j.unqualify(queryName)>
<#assign params = cfg.namedQueries.get(queryName).parameterTypes><#assign argList = c2j.asFinderArgumentList(params, pojo)>
<#if jdk5 && methname.startsWith("find")>
    public ${pojo.importType("java.util.List")}<${declarationName}> ${methname}(${argList});
<#elseif methname.startsWith("count")>
    public int ${methname}(${argList});
<#else>
    public ${pojo.importType("java.util.List")} ${methname}(${argList});
</#if>

</#if>
</#foreach></#if>
}
</#assign>

${pojo.generateImports()}
${classbody}
