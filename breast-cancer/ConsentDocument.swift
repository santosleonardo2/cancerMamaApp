//
//  ConsentDocument.swift
//  Teste
//
//  Created by leonardo on 1/23/16.
//  Copyright © 2016 Leonardo. All rights reserved.
//

import Foundation
import ResearchKit

public var ConsentDocument: ORKConsentDocument {
    let consentDocument = ORKConsentDocument()
    consentDocument.title = "Documento de consentimento"
    
    //Consent types
    let consentSectionTypes: [ORKConsentSectionType] = [
        .Overview,
        .DataGathering,
        .Privacy,
        .DataUse,
        .TimeCommitment,
        .StudySurvey,
        .StudyTasks,
        .Withdrawing
    ]
    var consentSections = [ORKConsentSection]()
    
    let overview = ORKConsentSection(type: .Overview)
    overview.summary = "Esta pesquisa tem o foco de estudar as reações do acrescimo de uma vitamina na dieta de portadores de cancer de mama."
    overview.content = ""
    consentSections += [overview]
    
    let dataGathering = ORKConsentSection(type: .DataGathering)
    dataGathering.summary = "Nessa pesquisa, vão ser coletados alguns dados de seu dia-a-dia."
    dataGathering.content = "..."
    consentSections += [dataGathering]
    
    let privacy =  ORKConsentSection(type: .Privacy)
    privacy.summary = "Todos os seus dados serão assegurados."
    privacy.content = "|||"
    consentSections += [privacy]
    
    let dataUse = ORKConsentSection(type: .DataUse)
    dataUse.summary = "Seus dados serão utilizados para uma pesquisa."
    dataUse.content = ".}}"
    consentSections += [dataUse]
    
    let timeCommitment = ORKConsentSection(type: .TimeCommitment)
    timeCommitment.summary = "Essa pesquisa vai usar de seu tempo!"
    timeCommitment.content = "..."
    consentSections += [timeCommitment]
    
    let studySurvey = ORKConsentSection(type: .StudySurvey)
    studySurvey.summary = "Essa pesquisa vai perguntar sua opnião."
    studySurvey.content = "..."
    consentSections += [studySurvey]
    
    let studyTasks = ORKConsentSection(type: .StudyTasks)
    studyTasks.summary = "Essa pesquisa lhe dará tarefas para fazer"
    studyTasks.content = "---"
    consentSections += [studyTasks]
    
    let withdraw = ORKConsentSection(type: .Withdrawing)
    withdraw.summary = "A qualquer momento você pode se desvincular a pesquisa"
    withdraw.content = "---"
    consentSections += [withdraw]
    
    consentDocument.sections = consentSections
    
    //Consent signature + review
    consentDocument.addSignature(ORKConsentSignature(forPersonWithTitle: nil, dateFormatString: nil, identifier: "ConsentDocumentParticipantSignature"))
    
    return consentDocument
}